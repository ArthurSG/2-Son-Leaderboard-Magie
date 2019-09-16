using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour {
  public float vitesseMax;

  private bool bloqueDeplacement = false;
  private float aimX, aimY;
  private Rigidbody2D rigid;
  private Animator animator;

  // Start is called before the first frame update
  void Start() {
    FetchComponents();
    SetControls();
  }

  // Update is called once per frame
  void Update() {
    
  }

  void Deplacements(float x, float y) {
    if (!bloqueDeplacement) {
      rigid.velocity = new Vector2(x * vitesseMax, y * vitesseMax);
      animator.SetFloat("Speed", Mathf.Abs(x) + Mathf.Abs(y));
    } else {
      rigid.velocity = Vector2.zero;
      animator.SetFloat("Speed", 0);
    }
  }

  void Aim(float x, float y) {
    aimX = x;
    aimY = y;
  }

  void Interaction() {
    print("Interaction");
  }

  void AnimationTeleport() {
    animator.SetTrigger("Teleport");
  }

  void Teleportation(){
    GetComponent<Teleportation>().Teleport(aimX, aimY);
  }

  public void AnimationRappel(){
    animator.SetTrigger("Rappel");
    
  }

  void Rappeler(){
    GetComponent<Teleportation>().Rappel();
  }

  void FetchComponents() {
    rigid = GetComponent<Rigidbody2D>();
    animator = GetComponent<Animator>();
  }

  void SetControls() {
    PlayerController.instance.OnSecondaryAxis += Aim;
    PlayerController.instance.OnPrimaryAxis += Deplacements;
    PlayerController.instance.OnPrimaryAction += AnimationTeleport;
    PlayerController.instance.OnSecondaryAction += Interaction;
  }

  void BloquerDeplacement(){
    bloqueDeplacement = true;
  }

  void LibererDeplacement(){
    bloqueDeplacement = false;
  }
}
