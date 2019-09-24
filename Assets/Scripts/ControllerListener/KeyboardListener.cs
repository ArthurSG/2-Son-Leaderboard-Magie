using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardListener : MonoBehaviour {
  private Camera cam;

  private Vector3 MouseDirection;
  private Vector3 oldMouseDirection;

  private ControllerFilter controllerFilter;
  public int controllerIndex = 1;
  public string controllerName = "Keyboard";

  private void Start() {
    cam = Camera.main;

    controllerFilter = GetComponent<ControllerFilter>();
  }


  void Update() {
    if(Input.GetButtonDown("PrimaryActionKeyboard")){
      controllerFilter.CallPrimaryAction(controllerIndex);
    }
    if (Input.GetButtonDown("SecondaryActionKeyboard")){
      controllerFilter.CallSecondaryAction(controllerIndex);     
    }

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("PrimaryAxisX");  
    float y = Input.GetAxis("PrimaryAxisY");
    if (!(x == 0 && y == 0)){
      controllerFilter.CallSetPrimaryAxis(controllerIndex,x,y);
    }
  }

  void HandleSecondaryAxis() {
    //MouseDirection = cam.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    MouseDirection =
      cam.ScreenPointToRay(Input.mousePosition).GetPoint(cam.gameObject.transform.localPosition.magnitude) -
      GameManager.instance.avatar.transform.position;
    ResetMouseDirection();
    if (Input.GetAxis("SecondaryAxisXMouse") != 0f || Input.GetAxis("SecondaryAxisYMouse") != 0f){
      controllerFilter.CallSetSecondaryAxis(controllerIndex, MouseDirection.x, MouseDirection.y);
    }
  }

  void ResetMouseDirection (){
    if (MouseDirection != oldMouseDirection) {
      ResetSecondaryAxis();
      oldMouseDirection = MouseDirection;
    }
  }

  public void ResetSecondaryAxis() {
        //Vector3 MouseDirection = cam.ScreenToWorldPoint(Input.mousePosition) - GameManager.instance.avatar.transform.position;
    MouseDirection =
      cam.ScreenPointToRay(Input.mousePosition).GetPoint(cam.gameObject.transform.localPosition.magnitude) -
      GameManager.instance.avatar.transform.position;
    controllerFilter.CallSetSecondaryAxis(controllerIndex, MouseDirection.x, MouseDirection.y);
  }
}
