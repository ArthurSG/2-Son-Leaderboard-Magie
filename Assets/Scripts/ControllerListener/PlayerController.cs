using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{

  public static PlayerController instance;

  private float primaryAxisX, primaryAxisY;
  private float secondaryAxisX, secondaryAxisY;

  public delegate void AxisFunction(float x, float y);
  public event AxisFunction OnPrimaryAxis;
  public event AxisFunction OnSecondaryAxis;

  public delegate void ActionFunction();
  public event ActionFunction OnPrimaryAction;
  public event ActionFunction OnSecondaryAction;

  void Awake() {
    SetStaticInstance();
  }

  void Update() {
    HandlePrimaryAxis();
    HandleSecondaryAxis();
  }

  void HandlePrimaryAxis() {
    if (OnPrimaryAxis != null)
      OnPrimaryAxis(primaryAxisX, primaryAxisY);
    primaryAxisX = 0f;
    primaryAxisY = 0f;
  }

  void HandleSecondaryAxis() {
    if (OnSecondaryAxis != null)
      OnSecondaryAxis(secondaryAxisX, secondaryAxisY);
    secondaryAxisX = 0f;
    secondaryAxisY = 0f;
  }

  public void SetPrimaryAxis(float x, float y) {
    primaryAxisX = x;
    primaryAxisY = y;
  }

  public void SetSecondaryAxis(float x, float y) {
    secondaryAxisX = x;
    secondaryAxisY = y;
  }

  public void PrimaryAction() {
    if (OnPrimaryAction != null)
      OnPrimaryAction();
  }

  public void SecondaryAction() {
    if (OnSecondaryAction != null)
      OnSecondaryAction();
  }

  void SetStaticInstance() {
    if (instance != null)
      print("/!\\ Two instances of PlayerController.");
    instance = this;
  }
}
