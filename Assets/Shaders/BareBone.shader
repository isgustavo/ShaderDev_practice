// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/BareBone" {

	Properties {

		_Color ("Main color", Color) = (1,1,1,1)
	}

	SubShader {

		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			uniform half4 _Color; 

			struct vertexInput {

				float4 vertex: POSITION;

			};

			struct vertexOutput {

				float4 pos: SV_POSITION;
			};


			vertexOutput vert (vertexInput v) {
				
				vertexOutput o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			half4 frag (vertexOutput i): Color {

				return _Color;
			}

			ENDCG
		}
	}

}