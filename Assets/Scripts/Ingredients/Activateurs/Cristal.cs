using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cristal : MonoBehaviour {
  private Animator animator;

  void Start() {
    animator = GetComponent<Animator>();
  }
  
  private void OnTriggerEnter2D(Collider2D collision) {
    if (collision.gameObject.tag == "Player") {
      GameManager.instance.avatar.AddCristal();
      PickedUp();
    }
  }

  private void PickedUp() {
    animator.SetTrigger("Picked up");
  }

  // Called et the end of the "Picked up" animation
  public void EndKeyLife() {
    Destroy(this.gameObject);
  }
}
