using System.Collections;
using System.Collections.Generic;
using UnityEngine;

abstract public class ControlerListener : MonoBehaviour {
  public delegate void MovementFunction(float x, float y);
  public delegate void ActionFunction();
  public event MovementFunction OnInputAxis;
  public event ActionFunction OnIntputAction;



  // Start is called before the first frame update
  void Start() {

  }

  // Update is called once per frame
  void Update() {

  }
}
