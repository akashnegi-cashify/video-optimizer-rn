## Add project specific ProGuard rules here.
## By default, the flags in this file are appended to flags specified
## in C:\Users\user\AppData\Local\Android\sdk/tools/proguard/proguard-android.txt
## You can edit the include path and order by changing the proguardFiles
## directive in build.gradle.
##
## For more details, see
##   http://developer.android.com/guide/developing/tools/proguard.html
#
## Add any project specific keep options here:
#
## If your project uses WebView with JS, uncomment the following
## and specify the fully qualified class name to the JavaScript interface
## class:
#
#-keep public class * extends android.app.Activity
#-keep public class * extends android.app.Application
#
#-keep public class * extends android.app.Service
#-keep public class * extends android.content.BroadcastReceiver
#-keep public class * extends android.content.ContentProvider
#-keep public class * extends in.cashify.androidtrc.common.api.BaseResponse
#-keepclassmembers class * implements android.os.Parcelable {
#      public static final android.os.Parcelable$Creator *;
#   }
#-keep class android.content.pm.** { *; }
#-keep public class * extends in.reglobe.api.client.service.IService{ *;}
#
### Keep GSON stuff
#-keepattributes Signature
#-keepattributes EnclosingMethod
#
#-dontwarn sun.misc.Unsafe.**
#-keep class sun.misc.Unsafe { *; }
#-keep class com.google.gson.** { *; }
#
#-dontwarn com.squareup.**
#-keep class com.squareup.** { *; }
#
#-dontwarn org.**
#-keep class org.** { *; }
#
#-dontwarn ezvcard.**
#-keep class ezvcard.** { *; }
#
#-dontwarn retrofit2.**
#-keep class retrofit2.** { *; }
#-keepattributes Exceptions
#
#-dontwarn okio.**
#-keep class okio.** { *; }
#
#
#-dontwarn com.google.firebase.**
#-keep class com.google.firebase.** { *; }
#
#
##to avoid name mangling issue with @Serialized names
#-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
#-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse$*{ *;}
#
#-keep public class com.google.android.gms.ads.identifier.** { *; }
#-keep public class com.google.android.gms.gcm.** { *; }
#-keep public class com.google.android.gms.common.** { *; }
#
#-keepclassmembers class ** {
#    public void onEvent(**);
#}
#
## For Test Fairy
#-keep class com.testfairy.** { *; }
#-dontwarn com.testfairy.**
#-keepattributes Exceptions, Signature, LineNumberTable
#
#-keepclassmembers class android.support.design.internal.BottomNavigationMenuView {
#    boolean mShiftingMode;
#}
#
#-dontwarn android.databinding.** -keep class android.databinding.** { *; }
#
#-dontwarn com.caverock.**
#-keep class com.caverock.**{*;}
#
#-dontwarn com.squareup.leakcanary.**
#-keep class com.squareup.leakcanary.**{*;}
#
#-dontwarn android.arch.lifecycle.**
#-keep class android.arch.lifecycle.**{*;}
#
#-dontwarn com.google.dagger.**
#-keep class com.google.dagger.**{*;}
#
#-dontwarn javax.annotation.**
#
## Platform calls Class.forName on types which do not exist on Android to determine platform.
#-dontnote retrofit2.Platform
## Platform used when running on Java 8 VMs. Will not be used at runtime.
#-dontwarn retrofit2.Platform$Java8
## Retain generic type information for use by reflection by converters and adapters.
## Retain declared checked exceptions for use by a Proxy instance.
#
#-dontwarn okhttp3.internal.platform.*
#
#
## com.google.errorprone
#-dontwarn com.google.errorprone.annotations.*
#
#-dontwarn com.android.installreferrer
#-dontwarn com.appsflyer.*
#
#-keep public class com.google.firebase.iid.FirebaseInstanceId {
#    public *;
#}
#
#
#-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
#-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
#-keep public class * extends in.reglobe.api.kotlin.service.APIService{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse{ *;}
#-keep public class in.reglobe.api.kotlin.exception.APIException{ *;}
#-keep public  enum in.reglobe.api.kotlin.exception.APIException.Kind{ *;}
#-keep public class in.reglobe.api.kotlin.exception.APIError{ *;}
#-keep public class in.reglobe.api.kotlin.exception.ApiErrorCode{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse.ServiceGroup*{ *;}
#
#-keep class * extends androidx.lifecycle.ViewModel { *;}
#
#
#-keep class com.amazonaws.** { *; }
#-keepnames class com.amazonaws.** { *; }




# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

###########################Monitoring
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions

-dontwarn okio.**
-keep class okio.** { *; }

-keepattributes Annotation
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**


##############################Shipex
-keepclassmembers class fqcn.of.javascript.interface.for.webview {
   public *;
}


-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application


-keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator CREATOR;
   }

## Keep GSON stuff

#to avoid name mangling issue with @Serialized names
-keep public class * extends in.cashify.androidtrc.common.api.BaseResponse{ *;}
#-keep public class * extends in.cashify.ops.assist.shipex.base.BaseApiRequest{ *;}
#-keep public class * extends in.cashify.ops.assist.shipex.base.BaseApiResponse{ *;}
-keep public class * extends in.reglobe.api.client.service.IService{ *;}

-keep public class com.google.android.gms.ads.identifier.** { *; }
-keep public class com.google.android.gms.gcm.** { *; }
-keep public class com.google.android.gms.common.** { *; }

-keepclassmembers class ** {
    public void onEvent(**);
}


-keepclassmembers class android.support.design.internal.BottomNavigationMenuView {
    boolean mShiftingMode;
}

-dontwarn android.databinding.**
-keep class android.databinding.** { *; }


-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception


-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**


-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**



# Preserve all annotations.
# Preserve R.*.* things.
-keepclassmembers class **.R$* {
    public static <fields>;
  }

# Preserve things required for parcelable classes.
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}
# Preserve serializable things.
-keepclassmembers class * implements java.io.Serializable {
        static final long serialVersionUID;
        static final java.io.ObjectStreamField[] serialPersistentFields;
        private void writeObject(java.io.ObjectOutputStream);
        private void readObject(java.io.ObjectInputStream);
        java.lang.Object writeReplace();
        java.lang.Object readResolve();
}

# Preserve enums.
-keepclassmembers class * extends java.lang.Enum {
        public static **[] values();
        public static ** valueOf(java.lang.String);
        }
# Preserve all .class method names.
 -keepclassmembernames class * {
    java.lang.Class class$(java.lang.String);
    java.lang.Class class$(java.lang.String, boolean);
 }
# Preserve all native method names and the names of their classes.
-keepclasseswithmembernames class * {
    native <methods>;
    }
# Ignore support lib warnings.
-dontwarn android.support.**
-dontwarn androidx.**
# Preserve support libs.
-keep interface android.support.v4.** { *; }
-keep interface android.support.v7.** { *; }
-keep interface androidx.** { *; }
-keep class android.support.** { *; }
# Preserve khosla labs libs.

-ignorewarnings
-keep class * {
    public private *;
}

-dontwarn android.arch.lifecycle.**
-keep class android.arch.lifecycle.**{*;}

-keep public class com.google.firebase.iid.FirebaseInstanceId {
    public *;
}

-keep class com.squareup.okhttp3.** {
*;
}

# Class names are needed in reflection
-keepnames class com.amazonaws.**
-keepnames class com.amazon.**
# Request handlers defined in request.handlers
-keep class com.amazonaws.services.**.*Handler
# The following are referenced but aren't required to run
-dontwarn com.fasterxml.jackson.**
-dontwarn org.apache.commons.logging.**
# Android 6.0 release removes support for the Apache HTTP client
-dontwarn org.apache.http.**
# The SDK has several references of Apache HTTP client
-dontwarn com.amazonaws.http.**
-dontwarn com.amazonaws.metrics.**


-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }

-keep class net.sqlcipher.** { *; }
-keep class net.sqlcipher.database.** { *; }

#####################qc-onsite
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator *;
   }
-keep class android.content.pm.** { *; }

## Keep GSON stuff
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


-keep public class * extends in.cashify.api.client.request.IRequest{ *;}
-keep public class * extends in.reglobe.api.client.response.IResponse{ *;}

-keepclassmembers class in.reglobe.cashify.appmodule.controller.WebLinkController {
    public *;
 }


# com.google.errorprone
-dontwarn com.google.errorprone.annotations.*

-dontwarn com.android.installreferrer
-dontwarn com.appsflyer.*

-dontwarn javax.annotation.**

# Platform calls Class.forName on types which do not exist on Android to determine platform.
-dontnote retrofit2.Platform
# Platform used when running on Java 8 VMs. Will not be used at runtime.
-dontwarn retrofit2.Platform$Java8
# Retain generic type information for use by reflection by converters and adapters.
# Retain declared checked exceptions for use by a Proxy instance.

-dontwarn okhttp3.internal.platform.*

#for amazon sdk
-keep class com.amazonaws.** { *; }
-keepnames class com.amazonaws.** { *; }
-dontwarn com.amazonaws.**
-dontwarn com.fasterxml.**


#-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
#-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse$*{ *;}
#-keep public class in.reglobe.api.kotlin.auth.AuthResponse.ServiceGroup*{ *;}
#-keep public class in.reglobe.api.kotlin.exception.APIException{ *;}
#-keep public enum in.reglobe.api.kotlin.exception.APIException.Kind{ *;}
#-keep public class in.reglobe.api.kotlin.exception.APIError{ *;}
#-keep public class in.reglobe.api.kotlin.exception.ApiErrorCode{ *;}

-keep class * extends androidx.lifecycle.ViewModel { *;}
-keep enum * { *; }

-keep class com.chuckerteam.chucker.** { *; }



# rules for tester App


-keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator *;
      static ** CREATOR;
   }




# For Test Fairy
-keep class com.testfairy.** { *; }
-dontwarn com.testfairy.**


-keep class com.truecaller.** { *; }
-keep class com.webengage.sdk.android.**{*;}


-dontwarn com.webengage.sdk.android.**
-keep class in.cashify.super_sales.analytics.**{*;}

-dontwarn com.caverock.**
-keep class com.caverock.**{*;}

-dontwarn com.squareup.leakcanary.**
-keep class com.squareup.leakcanary.**{*;}



# com.google.errorprone




-keep class in.cashify.super_sales.jscommunication.** { *; }
-keep class in.cashify.cashify_js_communication.** { *; }


-keep public class * extends in.reglobe.api.kotlin.request.IRequest{ *;}
-keep public class * extends in.reglobe.api.kotlin.response.IResponse{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse$*{ *;}
-keep public class in.reglobe.api.kotlin.auth.AuthResponse.ServiceGroup*{ *;}
-keep public class in.reglobe.api.kotlin.exception.APIException{ *;}
-keep public enum in.reglobe.api.kotlin.exception.APIException.Kind{ *;}
-keep public class in.reglobe.api.kotlin.exception.APIError{ *;}
-keep public class in.reglobe.api.kotlin.exception.ApiErrorCode{ *;}

