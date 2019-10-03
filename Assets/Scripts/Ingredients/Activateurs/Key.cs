using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key : MonoBehaviour {
  private Animator animator;

  void Start() {
    animator = GetComponent<Animator>();
  }
  private void OnTriggerEnter2D(Collider2D collision) {
    if(collision.gameObject.tag == "Player"){
      PickedUp();
    }
  }

  private void PickedUp() {
      GameManager.instance.avatar.AddKey();
      animator.SetTrigger("Picked up");
  }

  // Called et the end of the "Picked up" animation
  public void EndKeyLife() {
    Destroy(this.gameObject);
  }
}