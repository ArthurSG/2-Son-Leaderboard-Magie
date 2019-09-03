using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour {
  public float vitesseMax;

  private Rigidbody2D rig;

  // Start is called before the first frame update
  void Start() {
    rig = GetComponent<Rigidbody2D>();

    //enregistrer les fonctions de déplacement et d'action sur le Controler Listener
    ControllerListener controllerListener = GetComponent<ControllerListener>();
    controllerListener.OnInputAxis += Deplacements;
    controllerListener.OnIntputActionPrimaire += Teleportation;
    controllerListener.OnIntputActionSecondaire += Interaction;

  }

  // Update is called once per frame
  void Update() {
    
  }

  void Deplacements(float x, float y) {
    rig.velocity = new Vector2(x * vitesseMax, y * vitesseMax);
  }

  void Interaction() {
    print("Interaction");
  }

  void Teleportation() {
    print("Téléportation");
  }
}
