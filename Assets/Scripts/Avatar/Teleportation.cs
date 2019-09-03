using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleportation : MonoBehaviour {
  // Start is called before the first frame update
  private Vector3 positionSaved;

  void Start() {

  }

  // Update is called once per frame
  void Update() {

  }

  public void Teleport() {
    positionSaved = transform.position;

    // lancer anim


    // tp 
    // lancer timer
  }

  public void Rappel(){
    // anim de rappel
    if (positionSaved != null){
      transform.position = positionSaved;
    }
  }
}
