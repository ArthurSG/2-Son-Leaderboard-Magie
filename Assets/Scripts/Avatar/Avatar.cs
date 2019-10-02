﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Avatar : MonoBehaviour {
  public float vitesseMax;
  public Spirit spirit;
  public ParticleSystem HardWalkEffect;

  private bool bloqueDeplacement = false, isFacingRight = true;
  private float aimX, aimY;
  private Rigidbody2D rigid;
  private Animator animator;
  private Teleportation teleportComponent;
  public int Keys;
  public int Cristals;

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

  private void Flip (float x){
    if (x < 0 && isFacingRight) {
      this.transform.Find("Sprites").localScale = new Vector3 (-1,1,1);
      isFacingRight = !isFacingRight;
    }
    if (x > 0 && !isFacingRight) {
      this.transform.Find("Sprites").localScale = new Vector3 (1,1,1);
      isFacingRight = !isFacingRight;
    }
  }


  // Called by ControllerListener events
  private void Deplacements(float x, float y) {
    Flip(x);
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

  // Called by ControllerListener events
  private void Aim(float x, float y) {
    aimX = x;
    aimY = y;
    teleportComponent.MoveTeleportationTarget(new Vector2(x,y));
  }

  // Called by ControllerListener events
  private void Interaction() {
    foreach (Collider2D col in Physics2D.OverlapCircleAll(transform.position, 3f, LayerMask.GetMask("Floor", "Wall"))) {
       if (col.gameObject.tag == "Interactable")
        col.gameObject.GetComponent<Interactable>().Interact();
    }
  }

  // Called by ControllerListener events
  private void AnimationTeleport() {
    animator.SetTrigger(Teleport);
  }

  private void Teleportation(){
    teleportComponent.Teleport(new Vector2 (aimX, aimY));
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
    teleportComponent = GetComponent<Teleportation>();
    spirit = GameManager.instance.spirit.GetComponent<Spirit>();
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

  public void AddKey(){
    Keys++;
    CollectibleHUD.ShowOverlay();
  }

  public void SupprKey() {
    if (HasKey()) {
      Keys--;
      CollectibleHUD.ShowOverlay();
    }
  }

  public bool HasKey() {
    return Keys > 0;
  }

  public void AddCristal() {
    Cristals++;
    CollectibleHUD.ShowOverlay();
  }

  public void SupprCristal() {
    if (HasCristal()) {
      Cristals--;
      CollectibleHUD.ShowOverlay();
    }
  }

  public bool HasCristal() {
    return Cristals > 0;
  }
}
