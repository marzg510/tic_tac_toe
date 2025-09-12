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
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Keep Flutter activity classes
-keep class com.mardasoft.tic_tac_toe_app.MainActivity { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Keep all Activity classes
-keep class * extends android.app.Activity

# Keep all classes that extend Application
-keep class * extends android.app.Application

# Keep all View constructors
-keepclassmembers class * extends android.view.View {
   <init>(android.content.Context);
   <init>(android.content.Context, android.util.AttributeSet);
   <init>(android.content.Context, android.util.AttributeSet, int);
}

# Keep all Fragment classes
-keep class * extends androidx.fragment.app.Fragment
-keep class * extends android.app.Fragment

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep R class
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}