using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WalkEffect : MonoBehaviour
{
	public ParticleSystem walkParticle;

  	void Start(){
      //FetchComponents();
    }

    void ParticlePlay(){
    	walkParticle.Play();
    }

    void ParticleStop(){
   		walkParticle.Stop();
    }

    void FetchComponents (){

    	//walkParticle = GetComponent<ParticleSystem>();
    }
}
