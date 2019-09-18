using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LinkEffect : MonoBehaviour{

	private ParticleSystem particleSystem;
	//public GameObject spirit;

	private float magnitude;
	private Vector3 vecteurDistance;

  void Start(){
    FetchComponents ();


  }

  void Update(){
  	this.transform.LookAt(GameManager.instance.spirit.transform);

  	DistanceWithTarget ();
  	LifetimeModifier();
  }

  void DistanceWithTarget (){
  	vecteurDistance = this.transform.position - GameManager.instance.spirit.transform.position;
  	magnitude = vecteurDistance.magnitude;
  }


  void LifetimeModifier (){
  	particleSystem.startLifetime = magnitude * 0.05f;
  }



  void FetchComponents(){
  	particleSystem = GetComponent<ParticleSystem>();
  }
}
