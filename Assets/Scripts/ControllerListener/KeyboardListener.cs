using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardListener : MonoBehaviour {
  private Camera cam;
  private Vector3 oldDirection;

  private void Start() {
    cam = Camera.main;
  }

  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("PrimaryActionKeyboard"))
      PlayerController.instance.PrimaryAction();

    if (Input.GetButtonDown("SecondaryActionKeyboard"))
      PlayerController.instance.SecondaryAction();

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("PrimaryAxisX");
    float y = Input.GetAxis("PrimaryAxisY");
    if (!(x == 0 && y == 0))
      PlayerController.instance.SetPrimaryAxis(x, y);
  }

  void HandleSecondaryAxis() {
    Vector3 mousePosition = cam.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    if (mousePosition != oldDirection) {
      PlayerController.instance.SetSecondaryAxis(mousePosition.x, mousePosition.y);
      oldDirection = mousePosition;
    }
  }

  public void ResetSecondaryAxis() {
    // print("oui");
    Vector3 mousePosition = cam.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    PlayerController.instance.SetSecondaryAxis(mousePosition.x, mousePosition.y);
  }
}
