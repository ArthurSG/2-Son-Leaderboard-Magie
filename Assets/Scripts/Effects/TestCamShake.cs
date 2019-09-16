using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestCamShake : MonoBehaviour
{

  public float intensity = 1;
  public float waitTime = 2f;
  public int frames = 3;

  Vector3[] directions = { Vector3.up, Vector3.right, Vector3.down, Vector3.left };
  int directionIteration = 0;
  private IEnumerator coroutine;

  void Start() {
    coroutine = ScreenShakeFrequently();
    StartCoroutine(coroutine);
  }

  private IEnumerator ScreenShakeFrequently() {
    while (true) {
      yield return new WaitForSeconds(waitTime);
      VisualEffects.DirectionalScreenShake(directions[directionIteration], intensity, frames);
      directionIteration++ ;
      directionIteration %= 4;
      print(directionIteration); 
    }
  }

}
