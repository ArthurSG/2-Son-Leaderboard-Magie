using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundManager : MonoBehaviour{

	private AudioClip[] musics = new AudioClip[2];
	private AudioClip music1;
	private AudioClip music2;

	private int randomMusicInt;

	private AudioSource source1;

  void Start(){

  	FetchComponents();

  	
  		randomMusicInt = Random.Range(0,2);

  		print (randomMusicInt);

  		source1.clip = musics[randomMusicInt];
  		source1.Play(0);
  	

        
  } 

  void FetchComponents(){
  	source1 = GetComponent<AudioSource>();
  	musics[0] = Resources.Load<AudioClip>("Sounds/Music1");
  	musics[1]  = Resources.Load<AudioClip>("Sounds/Music2");
  }
}
