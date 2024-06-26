/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class JavaJniExperiment */

#ifndef _Included_JavaJniExperiment
#define _Included_JavaJniExperiment
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     JavaJniExperiment
 * Method:    print
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_JavaJniExperiment_print
  (JNIEnv *, jobject);

/*
 * Class:     JavaJniExperiment
 * Method:    reverse
 * Signature: (Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_JavaJniExperiment_reverse
  (JNIEnv *, jobject, jstring);

/*
 * Class:     JavaJniExperiment
 * Method:    matrixMultiplication
 * Signature: ([[I[[I)[[I
 */
JNIEXPORT jobjectArray JNICALL Java_JavaJniExperiment_matrixMultiplication
  (JNIEnv *, jobject, jobjectArray, jobjectArray);

/*
 * Class:     JavaJniExperiment
 * Method:    printArray
 * Signature: ([[I)V
 */
JNIEXPORT void JNICALL Java_JavaJniExperiment_printArray
  (JNIEnv *, jobject, jobjectArray);

#ifdef __cplusplus
}
#endif
#endif
