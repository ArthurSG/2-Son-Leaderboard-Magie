using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartAnimationAtRandomFrame : MonoBehaviour {
  public string animationName = "Idle";
  private Animator animator;

  void Start() {
    animator = GetComponent<Animator>();
    float randomTime = Random.Range(0f,1f);
    animator.Play(animationName, 0, randomTime);
  }

}
