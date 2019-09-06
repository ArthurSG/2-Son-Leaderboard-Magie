using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardListener : MonoBehaviour {
  private Camera camera;
  private Vector3 oldDirection;

  private void Start() {
    camera = GameManager.instance.camera;
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
    Vector3 mousePosition = camera.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    if (mousePosition != oldDirection) {
      PlayerController.instance.SetSecondaryAxis(mousePosition.x, mousePosition.y);
      oldDirection = mousePosition;
    }
  }

  public void ResetSecondaryAxis() {
    // print("oui");
    Vector3 mousePosition = camera.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    PlayerController.instance.SetSecondaryAxis(mousePosition.x, mousePosition.y);
  }
}
