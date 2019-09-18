using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarEffectsManager : MonoBehaviour{
  
  public List<ParticleSystem> Effects;

  void Start(){
    FetchComponents();
        
  }

  void Update(){
    print(Effects[1].isPlaying);
  }

  void EffectPlay(int Index){
  	if (!Effects[Index].isPlaying)
  		Effects[Index].Play();
  }

  void EffectStop (int Index){
  	if (Effects[Index].isPlaying)
  		Effects[Index].Stop();
  }

  void FetchComponents(){

  }
}
