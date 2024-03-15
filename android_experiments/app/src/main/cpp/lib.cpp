#include <jni.h>
#include <assert.h>


extern "C"
JNIEXPORT jstring JNICALL
Java_th_thesis_androidjni_NativeToJNI_reverse(JNIEnv *env, jobject thiz, jstring input) {
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
Java_th_thesis_androidjni_NativeToJNI_provideAnser(JNIEnv *env, jobject thiz) {
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