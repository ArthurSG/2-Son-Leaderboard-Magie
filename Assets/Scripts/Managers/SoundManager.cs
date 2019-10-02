using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundManager : MonoBehaviour{

	private AudioClip[] musics = new AudioClip[5];
	private AudioClip music1;
	private AudioClip music2;

	private int randomMusic;
	private int randomTimeBetweenSongs;

	private bool ready;
	private int i;

	private AudioSource source1;

  void Start(){

  	ready = true;
  	FetchComponents();

  	SongPlayer ();
  	 
  } 

  void SongPlayer (){
  	if (ready){
  		randomTimeBetweenSongs = Random.Range(1000,10000);
  		randomMusic = Random.Range(0,5);
  	
  		source1.clip = musics[randomMusic];
  		source1.Play(20);
  		ready = false;
  	}
  }

  void Update (){
  	if (!ready){
  		i ++;
  		if (i >= randomTimeBetweenSongs){
  			ready = true;
  			i = 0;
  			SongPlayer();			
  		}
  		
  	}
  }

  void FetchComponents(){
  	source1 = GetComponent<AudioSource>();
  	musics[0] = Resources.Load<AudioClip>("Sounds/Music1");
  	musics[1]  = Resources.Load<AudioClip>("Sounds/Music2");
  	musics[2] = Resources.Load<AudioClip>("Sounds/Music3");
  	musics[3]  = Resources.Load<AudioClip>("Sounds/Music4");
  	musics[4] = Resources.Load<AudioClip>("Sounds/Music5");

  }
}
