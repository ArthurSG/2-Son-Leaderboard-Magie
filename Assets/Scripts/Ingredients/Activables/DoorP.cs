using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorP : Activable {
  private Collider2D col;
  private Animator animator;

  new void Start() {
    base.Start();
    FetchComponents();
  }

  protected override void SetEtat() {
    if (NombreSourcesRequise > 0) {
      animator.SetBool("Opened", false);
      // col.isTrigger = false;
      // GetComponent<SpriteRenderer>().color = Color.red;
    }
    else {
      animator.SetBool("Opened", true);
      // col.isTrigger = true;
      // GetComponent<SpriteRenderer>().color = Color.green;
    }
  }

  void FetchComponents() {
    // col = GetComponent<Collider2D>();
    animator = GetComponent<Animator>();
  }
}
