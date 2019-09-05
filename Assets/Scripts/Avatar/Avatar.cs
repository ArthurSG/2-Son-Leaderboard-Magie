using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour {
  public float vitesseMax;


  private float aimX, aimY;
  private Rigidbody2D rigid;

  // Start is called before the first frame update
  void Start() {
    FetchComponents();
    SetControls();
  }

  // Update is called once per frame
  void Update() {
    
  }

  void Deplacements(float x, float y) {
    rigid.velocity = new Vector2(x * vitesseMax, y * vitesseMax);
  }

  void Aim(float x, float y) {
    aimX = x;
    aimY = y;
  }

  void Interaction() {
    print("Interaction");
  }

  void Teleportation() {
    GetComponent<Teleportation>().Teleport(aimX, aimY);
  }

  void FetchComponents() {
    rigid = GetComponent<Rigidbody2D>();
  }

  void SetControls() {
    PlayerController.instance.OnSecondaryAxis += Aim;
    PlayerController.instance.OnPrimaryAxis += Deplacements;
    PlayerController.instance.OnPrimaryAction += Teleportation;
    PlayerController.instance.OnSecondaryAction += Interaction;
  }
}
