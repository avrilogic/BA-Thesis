#include <jni.h>
#include <string>
#include <assert.h>

extern "C"
JNIEXPORT jstring JNICALL
Java_th_thesis_method_1channel_1jni_1test_1plugin_NativeToJni_reverse(JNIEnv *env, jobject thiz, jstring input) {
    const jchar* source = env->GetStringChars(input,0 );
    jsize len = env->GetStringLength(input);
    jchar* target = new jchar[len];
    for(int i=0;i<len;i++){
        target[i] = source[len-1-i];
    }
    env->ReleaseStringChars(input, source);
    return env->NewString(target,len);
}
extern "C"
JNIEXPORT void JNICALL
Java_th_thesis_method_1channel_1jni_1test_1plugin_NativeToJni_provideAnser(JNIEnv *env, jobject thiz) {
    jclass clazz = env->GetObjectClass(thiz);
    assert(clazz!=NULL);
    jfieldID fid = env->GetFieldID(clazz, "answer", "I");
    assert(fid != NULL);
    jint field =  env->GetIntField(thiz, fid);
    if(field==0)
        env->SetIntField(thiz, fid, 42);
    else
        env->SetIntField(thiz, fid, field*field);
}
extern "C"
JNIEXPORT jstring JNICALL
Java_th_thesis_method_1channel_1jni_1test_1plugin_NativeToJni_getHelloWorld(JNIEnv *env, jobject thiz) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C"
JNIEXPORT jbyteArray JNICALL
Java_th_thesis_method_1channel_1jni_1test_1plugin_NativeToJni_benchmark(JNIEnv *env, jobject thiz,
                                                                        jbyteArray request) {
    if (request == NULL) {
        return NULL; // Return NULL or throw an exception as per your error handling
    }
    jsize length = env->GetArrayLength(request);
    jbyte* elements = env->GetByteArrayElements(request, NULL);

    for (jsize i = 0; i < length; i++) {
        elements[i]++;
    }
    env->ReleaseByteArrayElements(request, elements, 0); // 0 to copy back the changes
    return request;
}