using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerZoneApneaCancel : MonoBehaviour {

	private Teleportation teleportation;

  void Start()
  {
      teleportation = GameManager.instance.avatar.gameObject.GetComponent<Teleportation>();
  }


  void Update()
  {
      
  }

  void OnTriggerEnter2D (Collider2D col){
  	teleportation.ApneaCancel();
  }
}