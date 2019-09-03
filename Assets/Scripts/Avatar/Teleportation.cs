using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleportation : MonoBehaviour {
  // Start is called before the first frame update
  public static float TeleportDuration = 3f;
  private Vector3 positionSaved;

  void Start() {

  }

  // Update is called once per frame
  void Update() {

  }

  public void Teleport(float aimX, float aimY) {
    positionSaved = transform.position;

    // lancer anim
    // tp 

    Timer t = new Timer(TeleportDuration, Rappel);        // temps avant le retour à la position d'origine
    t.Play();
  }

  public void Rappel(){
    // anim de rappel
    if (positionSaved != null){
      transform.position = positionSaved;
    }
  }
}
