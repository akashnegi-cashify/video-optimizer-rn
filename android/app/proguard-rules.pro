# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in C:\Users\user\AppData\Local\Android\sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application

-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends in.cashify.androidtrc.common.api.BaseResponse
-keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator *;
   }
-keep class android.content.pm.** { *; }
-keep public class * extends in.reglobe.api.client.service.IService{ *;}

## Keep GSON stuff
-keepattributes Signature
-keepattributes EnclosingMethod

-dontwarn sun.misc.Unsafe.**
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }

-dontwarn com.squareup.**
-keep class com.squareup.** { *; }

-dontwarn org.**
-keep class org.** { *; }

-dontwarn ezvcard.**
-keep class ezvcard.** { *; }

-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Exceptions

-dontwarn okio.**
-keep class okio.** { *; }


-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }


#to avoid name mangling issue with @Serialized names
-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse$*{ *;}

-keep public class com.google.android.gms.ads.identifier.** { *; }
-keep public class com.google.android.gms.gcm.** { *; }
-keep public class com.google.android.gms.common.** { *; }

-keepclassmembers class ** {
    public void onEvent(**);
}

# For Test Fairy
-keep class com.testfairy.** { *; }
-dontwarn com.testfairy.**
-keepattributes Exceptions, Signature, LineNumberTable

-keepclassmembers class android.support.design.internal.BottomNavigationMenuView {
    boolean mShiftingMode;
}

-dontwarn android.databinding.** -keep class android.databinding.** { *; }

-dontwarn com.caverock.**
-keep class com.caverock.**{*;}

-dontwarn com.squareup.leakcanary.**
-keep class com.squareup.leakcanary.**{*;}

-dontwarn android.arch.lifecycle.**
-keep class android.arch.lifecycle.**{*;}

-dontwarn com.google.dagger.**
-keep class com.google.dagger.**{*;}

-dontwarn javax.annotation.**

# Platform calls Class.forName on types which do not exist on Android to determine platform.
-dontnote retrofit2.Platform
# Platform used when running on Java 8 VMs. Will not be used at runtime.
-dontwarn retrofit2.Platform$Java8
# Retain generic type information for use by reflection by converters and adapters.
# Retain declared checked exceptions for use by a Proxy instance.

-dontwarn okhttp3.internal.platform.*


# com.google.errorprone
-dontwarn com.google.errorprone.annotations.*

-dontwarn com.android.installreferrer
-dontwarn com.appsflyer.*

-keep public class com.google.firebase.iid.FirebaseInstanceId {
    public *;
}


-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
-keep public class * extends in.reglobe.api.kotlin.service.APIService{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse{ *;}
-keep public class in.reglobe.api.kotlin.exception.APIException{ *;}
-keep public  enum in.reglobe.api.kotlin.exception.APIException.Kind{ *;}
-keep public class in.reglobe.api.kotlin.exception.APIError{ *;}
-keep public class in.reglobe.api.kotlin.exception.ApiErrorCode{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse.ServiceGroup*{ *;}

-keep class * extends androidx.lifecycle.ViewModel { *;}


-keep class com.amazonaws.** { *; }
-keepnames class com.amazonaws.** { *; }
-keepattributes InnerClasses,EnclosingMethod

