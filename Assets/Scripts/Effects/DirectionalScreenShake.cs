using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DirectionalScreenShake : MonoBehaviour
{
  private Camera cam;

  private Vector3 shakeDirection = Vector3.zero;
  private int nbFrameShake = 0;
  private float intensity = 0f;

  private bool isShakeEnding = false;
  private Vector3 cameraInitialPosition = Vector3.zero;

  public void Shake(Vector3 direction, float intensity, int frames) {
    this.shakeDirection = direction;
    this.intensity = intensity;
    this.nbFrameShake = frames;
    cameraInitialPosition = cam.transform.position;
  }


  void Update() {
    if (isShakeEnding) 
      ReturnCamToInitialPosition();
    else if (nbFrameShake != 0)
      MoveCamera();
  }

  void ReturnCamToInitialPosition () {
    cam.transform.position = cameraInitialPosition;
    isShakeEnding = false;
  }

  void MoveCamera() {
    Vector3 newPosition = cameraInitialPosition + shakeDirection * intensity;
    cam.transform.position = newPosition;
    intensity *= -0.5f;
    if (--nbFrameShake == 0)
      isShakeEnding = true;
  }

  void Start() {
    FetchComponents();
  }

  void FetchComponents() {
    cam = Camera.main;
  }
}
