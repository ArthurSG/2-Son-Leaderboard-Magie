using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardListener : MonoBehaviour {
  private Camera camera;

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
    float x = camera.ScreenToWorldPoint(Input.mousePosition).x - GameManager.instance.avatar.transform.position.x;
    float y = camera.ScreenToWorldPoint(Input.mousePosition).y - GameManager.instance.avatar.transform.position.y;
    if (Input.GetAxis("SecondaryAxisX") != 0 || Input.GetAxis("SecondaryAxisY") != 0)
      PlayerController.instance.SetSecondaryAxis(x, y);
  }
}
