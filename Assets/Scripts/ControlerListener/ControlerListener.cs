using System.Collections;
using System.Collections.Generic;
using UnityEngine;

abstract public class ControllerListener : MonoBehaviour {

  public delegate void MovementFunction(float x, float y);
  public event MovementFunction OnInputAxis;

  public delegate void ActionPrimaireFunction();
  public event ActionPrimaireFunction OnIntputActionPrimaire;

  public delegate void ActionSecondaireFunction();
  public event ActionSecondaireFunction OnIntputActionSecondaire;

  protected void PrimaryAxis(float x, float y) {
    if (OnInputAxis != null)
      OnInputAxis(x, y);
  }

  protected void ActionPrimaire() {
    if (OnIntputActionPrimaire != null)
      OnIntputActionPrimaire();
  }

  protected void ActionSecondaire() {
    if (OnIntputActionSecondaire != null)
      OnIntputActionSecondaire();
  }
}
