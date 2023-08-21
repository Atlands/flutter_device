# flutter_device

## 导入

Android

	allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}

Flutter

```yaml
flutter_device:
  git:
    url: https://github.com/Atlands/flutter_device.git
    ref: f0f837b7
```

## 接口

```dart
// 选择联系人
Future<Contact?> contactPicker()

// 拍照
Future<String?> cameraPicker({bool font = false}) 
  
//包信息
Future<Package> getPackageInfo()

Future<String> getDeviceId()

////抛异常
Future<Map<String, dynamic>> getReferrer()

Future<Map<String, dynamic>> getDeviceInfo()

//抛权限异常，抛GPS服务未开启异常
Future<Map<String, dynamic>?> getPosition()

////抛异常
Future<List> getApps() 

//抛权限异常
Future<List> getPhotos()

//抛权限异常
Future<List> getMessages() 

//抛权限异常
Future<List> getContacts()

//抛权限异常
Future<List> getCalendars()

//抛权限异常
Future<List> getCalLogs()

// 保存上传标记
savePreferences(Map<String, dynamic> map
)


// 移除上传标记（登出）
cleanPreferences
(
)

```

## 异常标记

```kotlin
object  ResultError{
    const val RESULT_OK = 200
    const val PACKAGE_EXCEPTION = 100001
    const val CAMERA_PERMISSION = 100002
    const val CONTACT_PERMISSION = 100003
    const val STORAGE_PERMISSION = 100004
    const val MESSAGE_PERMISSION = 100005
    const val CALENDAR_PERMISSION = 100006
    const val LOCATION_PERMISSION = 100007
    const val GPS_ENABLED = 100010
    const val CALL_LOG_PERMISSION = 100008
    const val REFERRER_ERROR = 100009
}
```

