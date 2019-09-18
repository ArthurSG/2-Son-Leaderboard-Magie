using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarEffectsManager : MonoBehaviour{
  
  public List<ParticleSystem> Effects;

  void Start(){
    FetchComponents();
        
  }

  void Update(){
        
  }

  void AllerEffectsPlay(){
  	foreach (ParticleSystem ps in Effects){
  		ps.Play();
  	}
  }

  void RetourEffectsStop(){
  	foreach (ParticleSystem ps in Effects){
  		ps.Stop();
  	}
  }



  void FetchComponents(){

  }
}
