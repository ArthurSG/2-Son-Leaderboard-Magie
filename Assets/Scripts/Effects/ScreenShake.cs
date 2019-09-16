using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenShake : MonoBehaviour
{

  private Camera cam;
  private Vector2 camShakeDirection;

  public void Shake() {

  }

  void Start() {
    FetchComponents();
  }

  void FetchComponents() {
    cam = Camera.main;
  }

}
