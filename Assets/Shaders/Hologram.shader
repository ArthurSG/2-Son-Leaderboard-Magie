Shader "Unlit/Hologram"
{
    Properties
    {
        _MainTex ("Texture de test", 2D) = "white" {}
        _TintColor ("Tint Color", Color) = (1,1,1,1)
        _Transparency ("transparance", Range(0.0,0.5)) = 0.25
        _CutoutThreshold("Cutout threshold", Range(0.0,1.0)) = .2
        _Distance("Distance", Float) = 1
        _Amplitude("Amplitude", Float) = 1
        _Speed("Speed", Float) = 1
        _Amount("Amount", Float) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _TintColor;
            float _Transparency;
            float _CutoutThreshold;
            float _Amount;
            float _Amplitude;
            float _Speed;
            float _Distance;
            v2f vert (appdata v)
            {
                v.vertex.x += sin(_Time.y * _Speed + v.vertex.y *_Amplitude);
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv) * _TintColor;
                col.a = _Transparency;
                clip(col.r - _CutoutThreshold);
                // if (col.r < _CutoutThreshold) discard;
                return col;
            }
            ENDCG
        }
    }
}
