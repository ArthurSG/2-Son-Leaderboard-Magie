using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarEffectsManager : MonoBehaviour{
  
  public List<ParticleSystem> Effects;

  void Start(){
    FetchComponents();
        
  }

  void Update(){
    print(Effects[1].particleCount);
  }

  void EffectPlay(int Index){
  	Effects[Index].Play();
  }

  void EffectStop (int Index){
  	Effects[Index].Stop();
  }

  void FetchComponents(){

  }
}
