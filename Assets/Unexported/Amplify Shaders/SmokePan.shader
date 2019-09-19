// Upgrade NOTE: upgraded instancing buffer 'SmokePan' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SmokePan"
{
	Properties
	{
		_Tex1("Tex1", 2D) = "white" {}
		_ColorTex1("Color Tex1", Color) = (1,1,1,0)
		_TilingTex1("Tiling Tex1", Vector) = (1,1,0,0)
		_PanSpeedTex1("Pan Speed Tex1", Float) = 1
		_OpacityTex1("Opacity Tex1", Float) = 1
		[HDR]_EmissiveColorTex1("EmissiveColor Tex1", Color) = (1,1,1,0)
		_EmissiveStrengthTex1("EmissiveStrength Tex1", Float) = 1
		_Tex2("Tex2", 2D) = "white" {}
		_ColorTex2("Color Tex2", Color) = (1,1,1,0)
		_TilingTex2("Tiling Tex2", Vector) = (1,1,0,0)
		_PanSpeedTex2("Pan Speed Tex2", Float) = 1
		_OpacityTex2("Opacity Tex2", Float) = 1
		[HDR]_EmissiveColorTex2("EmissiveColor Tex2", Color) = (1,1,1,0)
		_EmissiveStrengthTex2("EmissiveStrength Tex2", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma multi_compile_instancing
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Tex2;
		uniform sampler2D _Tex1;

		UNITY_INSTANCING_BUFFER_START(SmokePan)
			UNITY_DEFINE_INSTANCED_PROP(float4, _ColorTex2)
#define _ColorTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _ColorTex1)
#define _ColorTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _EmissiveColorTex1)
#define _EmissiveColorTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _EmissiveColorTex2)
#define _EmissiveColorTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float2, _TilingTex2)
#define _TilingTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float2, _TilingTex1)
#define _TilingTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _PanSpeedTex2)
#define _PanSpeedTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _OpacityTex2)
#define _OpacityTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _PanSpeedTex1)
#define _PanSpeedTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _OpacityTex1)
#define _OpacityTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _EmissiveStrengthTex1)
#define _EmissiveStrengthTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _EmissiveStrengthTex2)
#define _EmissiveStrengthTex2_arr SmokePan
		UNITY_INSTANCING_BUFFER_END(SmokePan)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 _ColorTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_ColorTex2_arr, _ColorTex2);
			float2 _TilingTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_TilingTex2_arr, _TilingTex2);
			float _PanSpeedTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_PanSpeedTex2_arr, _PanSpeedTex2);
			float4 appendResult22 = (float4(( _PanSpeedTex2_Instance * _Time.y ) , 0.0 , 0.0 , 0.0));
			float2 uv_TexCoord24 = i.uv_texcoord * _TilingTex2_Instance + appendResult22.xy;
			float4 tex2DNode25 = tex2D( _Tex2, uv_TexCoord24 );
			float _OpacityTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_OpacityTex2_arr, _OpacityTex2);
			float temp_output_34_0 = ( tex2DNode25.a * _OpacityTex2_Instance );
			float4 _ColorTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_ColorTex1_arr, _ColorTex1);
			float2 _TilingTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_TilingTex1_arr, _TilingTex1);
			float _PanSpeedTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_PanSpeedTex1_arr, _PanSpeedTex1);
			float4 appendResult12 = (float4(( _PanSpeedTex1_Instance * _Time.y ) , 0.0 , 0.0 , 0.0));
			float2 uv_TexCoord6 = i.uv_texcoord * _TilingTex1_Instance + appendResult12.xy;
			float4 tex2DNode1 = tex2D( _Tex1, uv_TexCoord6 );
			float _OpacityTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_OpacityTex1_arr, _OpacityTex1);
			float temp_output_36_0 = ( tex2DNode1.a * _OpacityTex1_Instance );
			float _EmissiveStrengthTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveStrengthTex1_arr, _EmissiveStrengthTex1);
			float4 _EmissiveColorTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveColorTex1_arr, _EmissiveColorTex1);
			float _EmissiveStrengthTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveStrengthTex2_arr, _EmissiveStrengthTex2);
			float4 _EmissiveColorTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveColorTex2_arr, _EmissiveColorTex2);
			o.Emission = ( ( ( ( _ColorTex2_Instance * step( 1E-09 , tex2DNode25.a ) ) * tex2DNode25 * temp_output_34_0 ) + ( ( _ColorTex1_Instance * step( 1E-09 , tex2DNode1.a ) ) * tex2DNode1 * temp_output_36_0 ) ) + ( ( ( tex2DNode1 * ( temp_output_36_0 * ( _EmissiveStrengthTex1_Instance * _EmissiveColorTex1_Instance ) ) ) * _EmissiveColorTex1_Instance.a ) + ( ( tex2DNode25 * ( temp_output_34_0 * ( _EmissiveStrengthTex2_Instance * _EmissiveColorTex2_Instance ) ) ) * _EmissiveColorTex2_Instance.a ) ) ).rgb;
			float temp_output_28_0 = ( temp_output_34_0 + temp_output_36_0 );
			o.Alpha = temp_output_28_0;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
323;73;1173;656;1663.419;2120.712;2.861647;False;False
Node;AmplifyShaderEditor.CommentaryNode;43;-2615.742,-683.9781;Float;False;2050.046;631.7319;Tex1;14;39;56;40;1;36;35;6;9;12;11;10;5;58;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;42;-2595.304,-1352.648;Float;False;2032.745;653.5192;Tex2;14;63;38;61;37;34;62;25;33;24;22;23;21;20;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-2545.304,-874.8633;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2562.442,-280.6849;Float;False;InstancedProperty;_PanSpeedTex1;Pan Speed Tex1;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-2565.74,-177.2336;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2542.005,-980.0916;Float;False;InstancedProperty;_PanSpeedTex2;Pan Speed Tex2;11;0;Create;True;0;0;False;0;1;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-2328.827,-258.1728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2308.391,-955.8027;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;23;-2306.157,-1159.251;Float;False;InstancedProperty;_TilingTex2;Tiling Tex2;9;0;Create;True;0;0;False;0;1,1;0.16,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;12;-2158.832,-280.2135;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-2138.396,-977.8436;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;9;-2326.593,-461.6207;Float;False;InstancedProperty;_TilingTex1;Tiling Tex1;2;0;Create;True;0;0;False;0;1,1;0.13,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;41;-1591.395,58.94537;Float;False;1465.936;515.8126;Emissive Tex1;6;51;18;32;15;16;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1982.678,-1111.421;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-2003.114,-413.7911;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;44;-1597.78,624.5864;Float;False;1454.495;508.9487;Emissive Tex2;6;50;46;45;47;48;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1751.926,-209.8223;Float;False;InstancedProperty;_OpacityTex1;Opacity Tex1;4;0;Create;True;0;0;False;0;1;0.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;46;-1499.402,921.0676;Float;False;InstancedProperty;_EmissiveColorTex2;EmissiveColor Tex2;13;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-1665.796,-1121.159;Float;True;Property;_Tex2;Tex2;7;0;Create;True;0;0;False;0;b7f723f2e0d2e054fb0fcf67b501d9df;f3c395d391b08cd46b2408019d523940;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-1645.638,-868.4955;Float;False;InstancedProperty;_OpacityTex2;Opacity Tex2;12;0;Create;True;0;0;False;0;1;0.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1764.843,-418.9814;Float;True;Property;_Tex1;Tex1;0;0;Create;True;0;0;False;0;f3c395d391b08cd46b2408019d523940;f3c395d391b08cd46b2408019d523940;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-1549.177,810.4489;Float;False;InstancedProperty;_EmissiveStrengthTex2;EmissiveStrength Tex2;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-1444.97,360.8943;Float;False;InstancedProperty;_EmissiveColorTex1;EmissiveColor Tex1;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,23.49651,27.53272,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1541.395,240.6194;Float;False;InstancedProperty;_EmissiveStrengthTex1;EmissiveStrength Tex1;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1690.112,-1235.789;Float;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;False;0;1E-09;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1163.034,775.0073;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1365.005,-868.9063;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1156.649,209.3663;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1712,-512;Float;False;Constant;_Float0;Float 0;14;0;Create;True;0;0;False;0;1E-09;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1470.042,-230.2866;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-1552.236,-638.8429;Float;False;InstancedProperty;_ColorTex1;Color Tex1;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;58;-1440,-464;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-875.2534,148.1491;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-885.092,712.0634;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;37;-1465.296,-1300.347;Float;False;InstancedProperty;_ColorTex2;Color Tex2;8;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;61;-1361.755,-1091.177;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1160.079,-1247.137;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1200,-624;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-655.1268,674.5864;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-648.7415,108.9454;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-858.8762,-605.3879;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-873.7838,-1220.974;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-366.3369,700.0729;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-334.7178,146.1263;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-34.68869,189.0783;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-242.9336,-730.3238;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;92;-2729.82,-2309.506;Float;False;2089.335;951.2343;Alpha mask;26;94;95;81;84;86;89;79;91;72;90;88;87;82;77;73;70;65;76;74;75;68;66;71;67;100;101;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-609.3583,-1579.59;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;99;-297.9131,-1775.3;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2472.003,-1489.702;Float;False;Constant;_Float3;Float 3;16;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;74;-2504.162,-1659.913;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;65;-1269.705,-1986.319;Float;True;Property;_SmokeMask;SmokeMask;15;0;Create;True;0;0;False;0;None;f3c395d391b08cd46b2408019d523940;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;55;166.0371,-76.93557;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2227.551,-1630.349;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-935.8783,-1857.981;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1300.814,-1675.07;Float;False;InstancedProperty;_AdditionalMaskScale;Additional Mask Scale;16;0;Create;True;0;0;False;0;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;66;-2258.087,-1716.237;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;100;-1736.601,-2194.094;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;67;-2239.187,-1803.265;Float;False;InstancedProperty;_Float2;Float 2;10;0;Create;True;0;0;False;0;1;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-2444.644,-1854.948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;82;-2097.307,-2183.253;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2258.836,-2232.92;Float;False;Constant;_Float6;Float 6;16;0;Create;True;0;0;False;0;-0.24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1911.375,-1642.421;Float;False;Constant;_Float7;Float 7;16;0;Create;True;0;0;False;0;-2.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2424.76,-1962.589;Float;False;Constant;_Float9;Float 9;16;0;Create;True;0;0;False;0;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;72;-2635.26,-2159.138;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;86;-2608.475,-1956.966;Float;False;Constant;_Float8;Float 8;16;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-2527.098,-2259.506;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;6.34;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;90;-2679.82,-1867.229;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;88;-2255.178,-1903.528;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2005.574,-1778.976;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-2113.26,-1999.591;Float;False;Constant;_Float4;Float 4;16;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-1885.868,-1987.005;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;70;-1753.945,-1794.925;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;71;-1679.86,-1934.594;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2286.773,-2134.673;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1420.818,-2009.202;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;14;421.9813,-55.95913;Float;False;True;6;Float;ASEMaterialInspector;0;0;Unlit;SmokePan;False;False;False;False;True;True;True;True;True;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;3;40;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;5;0
WireConnection;11;1;10;0
WireConnection;21;0;20;0
WireConnection;21;1;19;0
WireConnection;12;0;11;0
WireConnection;22;0;21;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
WireConnection;6;0;9;0
WireConnection;6;1;12;0
WireConnection;25;1;24;0
WireConnection;1;1;6;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;34;0;25;4
WireConnection;34;1;33;0
WireConnection;15;0;17;0
WireConnection;15;1;16;0
WireConnection;36;0;1;4
WireConnection;36;1;35;0
WireConnection;58;0;59;0
WireConnection;58;1;1;4
WireConnection;32;0;36;0
WireConnection;32;1;15;0
WireConnection;48;0;34;0
WireConnection;48;1;47;0
WireConnection;61;0;62;0
WireConnection;61;1;25;4
WireConnection;63;0;37;0
WireConnection;63;1;61;0
WireConnection;56;0;39;0
WireConnection;56;1;58;0
WireConnection;49;0;25;0
WireConnection;49;1;48;0
WireConnection;18;0;1;0
WireConnection;18;1;32;0
WireConnection;40;0;56;0
WireConnection;40;1;1;0
WireConnection;40;2;36;0
WireConnection;38;0;63;0
WireConnection;38;1;25;0
WireConnection;38;2;34;0
WireConnection;50;0;49;0
WireConnection;50;1;46;4
WireConnection;51;0;18;0
WireConnection;51;1;16;4
WireConnection;52;0;51;0
WireConnection;52;1;50;0
WireConnection;27;0;38;0
WireConnection;27;1;40;0
WireConnection;28;0;34;0
WireConnection;28;1;36;0
WireConnection;99;0;28;0
WireConnection;99;1;94;0
WireConnection;65;1;101;0
WireConnection;55;0;27;0
WireConnection;55;1;52;0
WireConnection;75;0;74;1
WireConnection;75;1;76;0
WireConnection;94;0;65;4
WireConnection;94;1;95;0
WireConnection;87;0;86;0
WireConnection;87;1;90;2
WireConnection;82;0;81;0
WireConnection;82;1;77;0
WireConnection;88;0;89;0
WireConnection;88;1;87;0
WireConnection;68;0;67;0
WireConnection;68;1;66;0
WireConnection;73;0;82;0
WireConnection;73;1;88;0
WireConnection;70;0;68;0
WireConnection;70;1;84;0
WireConnection;71;0;73;0
WireConnection;71;1;70;0
WireConnection;77;0;79;0
WireConnection;77;1;72;2
WireConnection;101;0;100;0
WireConnection;101;1;71;0
WireConnection;14;2;55;0
WireConnection;14;9;28;0
ASEEND*/
//CHKSM=6D5F10EF9AE445FC8FD601DD7892C64C4B544C0A