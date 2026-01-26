import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../constants.dart';
import '../models/ble_model.dart';


class BluetoothManager{
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    _instance.listenBLEStatu();

    return _instance;
  }

  BluetoothManager._internal();

  final _ble = FlutterReactiveBle();

  /// 最多支持 3 台 Spin Defender
  static const int maxConnectedCount = 3;

  /// 已连接设备 Map（deviceId -> model）
  final Map<String, BLEModel> connectedDeviceMap = {};

  // 蓝牙列表
  List<BLEModel> deviceList = [];

  List<BLEModel> get showDeviceList {
    List<BLEModel> virtualList = [];

    this.deviceList.forEach((element){
      virtualList.add(element);


    });
    print("扫描到的蓝牙设备${virtualList}");
    return virtualList;
  }

  // 已连接设备列表
  List<BLEModel> get connectedDevices {
    return connectedDeviceMap.values.toList();
  }


  // 已连接的蓝牙设备列表
  List<BLEModel>  get hasConnectedDeviceList  {
    return  this.deviceList.where((element) => element.hasConected == true).toList();
  }


  final ValueNotifier<int> deviceListLength = ValueNotifier(-1);

  // 已连接的设备数量
  final ValueNotifier<int> conectedDeviceCount = ValueNotifier(0);

  Stream<DiscoveredDevice>? _scanStream;

  StreamSubscription? _bleStatuListen;
  StreamSubscription? _bleListen;

  Function(int measuredSpeed)? dataChange; // 测量到速度变化
  Function()? disConnect; // 机器人断链

  /// 蓝牙设备列表版本号（任意设备状态变化 +1）
  final ValueNotifier<int> deviceListVersion = ValueNotifier(0);


  /*开始扫描*/
  Future<void> startNewScan() async {
    // 不能重复扫描
    if (_scanStream != null) {
      print('返回了');
      return;
    }
    _scanStream = _ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    );
    _bleListen = _scanStream!.listen((DiscoveredDevice event) {
      // 处理扫描到的蓝牙设备
      if (event.name.isEmpty) {
        return;
      }
      if(!event.name.contains(kBLEDevice_NewName)){
        // 蓝牙名称过滤
        return;
      }
      //  && event.name == kBLEDevice_NewName
      if (!hasDevice(event.id) ) {
        print('蓝牙名字${event.name}');
        this.deviceList.add(BLEModel(device: event));
        deviceListLength.value = this.deviceList.length;
        var model = this.deviceList.last;
        if (conectedDeviceCount.value == 0 && model.device.name == kBLEDevice_NewName) {
          // 已经连接的设备少于两个 则自动连接
          // conectToDevice(this.deviceList.last);
          // BluetoothManager().blueNameChange?.call(model.device.name);
        }
      }
    });
  }


  /*连接设备*/
  conectToDevice(BLEModel model) {
    if (model.hasConected == true ||
        connectedDeviceMap.length >= maxConnectedCount) {
      print('已达到最大连接数量');
      return;
    }

    StreamSubscription<ConnectionStateUpdate> stream =  _ble
        .connectToDevice(
        id: model.device.id, connectionTimeout: Duration(seconds: 10))
        .listen((ConnectionStateUpdate connectionStateUpdate) {
      print('connectionStateUpdate = ${connectionStateUpdate.connectionState}');
      if (connectionStateUpdate.connectionState ==
          DeviceConnectionState.connected) {
        // 连接成功主动发送心跳回复响应(获取准确电量)
        // BLESendUtil.heartBeatResponse();
        if(Platform.isAndroid){
          // 请求高优先级连接
        //  _ble.requestConnectionPriority(deviceId: model.device!.id, priority: ConnectionPriority.highPerformance);
        }
        // 连接设备数量+1
        conectedDeviceCount.value++;
        // 已连接
        model.hasConected = true;

        /// ⭐⭐⭐ 核心：加入已连接设备池
        connectedDeviceMap[model.device.id] = model;

        deviceListVersion.value++;


        // 保存读写特征值
        late final notifyCharacteristic;
        late final writerCharacteristic;
        // if(model.device.name == kBLEDevice_NewName){
          // seeker bot
          notifyCharacteristic = QualifiedCharacteristic(
              serviceId: Uuid.parse(kBLE_270_SERVICE_UUID),
              characteristicId: Uuid.parse(kBLE_270_CHARACTERISTIC_NOTIFY_UUID),
              deviceId: model.device.id);
        writerCharacteristic = QualifiedCharacteristic(
            serviceId: Uuid.parse(kBLE_270_SERVICE_UUID),
            characteristicId: Uuid.parse(kBLE_270_CHARACTERISTIC_WRITER_UUID),
            deviceId: model.device.id);
          model.notifyCharacteristic = notifyCharacteristic;
model.writerCharacteristic = writerCharacteristic;
          Future.delayed(Duration(milliseconds: 2000),(){
            //writerDataToDevice(model, startData());
          });
       // }




        // 监听数据
        // Future.delayed(Duration(milliseconds: 2000),(){
        _ble.subscribeToCharacteristic(notifyCharacteristic).listen((data) {
          print("deviceId =${model.device.id}---上报来的数据data = $data");
          List<int> bytes = data;
          BluetoothManager().dataChange?.call(bytes[0]);
        });
        // });
      } else if (connectionStateUpdate.connectionState ==
          DeviceConnectionState.disconnected) {

        BluetoothManager().disConnect?.call();
        connectedDeviceMap.remove(model.device.id);

        if (conectedDeviceCount.value > 0) {
          conectedDeviceCount.value--;
        }
        model.hasConected = false;
        deviceList.remove(model);
        deviceListLength.value = deviceList.length;

        deviceListVersion.value++;

      }
    });
    model.bleStream = stream;
  }

  /*断开连接*/
  disconnectDevice(BLEModel model) {
    model.bleStream?.cancel();

    connectedDeviceMap.remove(model.device.id);

    if (conectedDeviceCount.value > 0) {
      conectedDeviceCount.value--;
      if (conectedDeviceCount.value == 0) {
        _bleListen?.cancel();
        _bleListen = null;
        _scanStream = null;
      }
    }

    model.hasConected = false;
  }


  /*判断是否已经被添加设备列表*/
  bool hasDevice(String id) {
    Iterable<BLEModel> filteredDevice =
    this.deviceList.where((element) => element.device.id == id);
    return filteredDevice != null && filteredDevice.length > 0;
  }

  listenBLEStatu() {
    if (_bleStatuListen == null) {
      _bleStatuListen = FlutterReactiveBle().statusStream.listen((status) {
        print('蓝牙状态status===${status}');
        // GameUtil gameUtil = GetIt.instance<GameUtil>();
        // gameUtil.bleStatus = status;
        if (status == BleStatus.poweredOff) {
          // 蓝牙开关关闭
          _instance._bleListen?.cancel();
          _instance._bleListen = null;
          _instance._scanStream = null;
          // _instance.disConnect?.call();
          print('蓝牙关闭');
        } else if (status == BleStatus.locationServicesDisabled) {
          // 安卓位置权限不允许
        } else if (status == BleStatus.unauthorized) {
          // 未授权蓝牙权限
        } else if (status == BleStatus.ready) {
          // _instance.openBlueTooth?.call();
          print('蓝牙打开');
          Future.delayed(Duration(milliseconds: 100),(){
            startNewScan();
          });

        }
      });
    }
  }

  /*发送数据*/
  Future<void> writerDataToDevice(BLEModel model, List<int> data) async {
    //  数据校验
    if (data == null || data.length == 0) {
      return;
    }
    // 确认蓝牙设备已连接 并保存对应的特征值
    if (model == null ||
        model.hasConected == null ||
        model.writerCharacteristic == null) {
      return;
    }
    // 多个命令同时发时 增加10ms的时间间隔
    sleep(Duration(milliseconds: 10));
    print('999${model}');
    // Future.delayed(Duration(milliseconds: 50),() async{
    _ble.writeCharacteristicWithResponse(model.writerCharacteristic!,
        value: data);
  }

  /*
  * 给某设备发送数据
  * 示例如下：
  * sendToDevice(deviceIdA, setSpeedData(60));
   sendToDevice(deviceIdB, setSpeedData(40));
   sendToDevice(deviceIdC, stopData());
  * */
  Future<void> sendToDevice(
      String deviceId,
      List<int> data,
      ) async {
    final model = connectedDeviceMap[deviceId];
    if (model == null) return;
    await writerDataToDevice(model, data);
  }

  /*
  * 广播给所有已连接 Spin Defender
  * */
  Future<void> sendToAll(List<int> data) async {
    for (final model in connectedDeviceMap.values) {
      await writerDataToDevice(model, data);
    }
  }



}
