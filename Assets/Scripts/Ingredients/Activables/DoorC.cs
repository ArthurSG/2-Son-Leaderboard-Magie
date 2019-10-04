using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorC : MonoBehaviour {
	private bool isOpen = false;
  private Animator animator;

  void Start() {
    animator = GetComponent<Animator>();
  }

  private void OnTriggerEnter2D(Collider2D other) {
    if (other.gameObject.tag == "Player" && GameManager.instance.avatar.HasKey() && !isOpen) 
      Open();
  }

  private void Open() {
    GameManager.instance.avatar.SupprKey();
    animator.SetBool("Opened", true);
    isOpen = true;
  }
}
