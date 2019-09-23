using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour {
  public float vitesseMax;
  public GameObject spirit;

  public ParticleSystem HardWalkEffect;

  private bool bloqueDeplacement = false;
  private float aimX, aimY;
  private Rigidbody2D rigid;
  private Animator animator;

  [HideInInspector] public bool isInTP;
  // Animator strings
  private static readonly int Rappel = Animator.StringToHash("Rappel");
  private static readonly int Speed = Animator.StringToHash("Speed");
  private static readonly int Teleport = Animator.StringToHash("Teleport");

  // Start is called before the first frame update
  private void Start() {
    FetchComponents();
    SetControls();
  }


  private void Deplacements(float x, float y) {
    if (!bloqueDeplacement) {
      rigid.velocity = new Vector2(x, y).normalized * vitesseMax;

      if (animator.GetCurrentAnimatorStateInfo(0).IsName("Idle") && (x != 0 || y != 0)){
        if (!HardWalkEffect.isPlaying)
          HardWalkEffect.Play();
      }
      animator.SetFloat(Speed, Mathf.Abs(x) + Mathf.Abs(y));

      if (x == 0 && y == 0)
        if (HardWalkEffect.isPlaying)
          HardWalkEffect.Stop();
    } else {

      rigid.velocity = Vector2.zero;
      animator.SetFloat(Speed, 0);


    }
  }

  private void Aim(float x, float y) {
    aimX = x;
    aimY = y;
  }

  private void Interaction() {
    print("Interaction");
  }

  private void AnimationTeleport() {
    animator.SetTrigger(Teleport);
  }

  private void Teleportation(){
    GetComponent<Teleportation>().Teleport(aimX, aimY);
  }

  public void AnimationRappel(){
    animator.SetTrigger(Rappel);
    
  }

  private void Rappeler(){
    GetComponent<Teleportation>().Rappel();
  }

  private void FetchComponents() {
    rigid = GetComponent<Rigidbody2D>();
    animator = GetComponent<Animator>();
    spirit = GameManager.instance.spirit;
  }

  private void SetControls() {
    PlayerController.instance.OnSecondaryAxis += Aim;
    PlayerController.instance.OnPrimaryAxis += Deplacements;
    PlayerController.instance.OnPrimaryAction += AnimationTeleport;
    PlayerController.instance.OnSecondaryAction += Interaction;
  }

  private void BloquerDeplacement(){
    bloqueDeplacement = true;
  }

  private void LibererDeplacement(){
    bloqueDeplacement = false;
  }
}
