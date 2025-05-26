
Shader "Custom/CircularPulseShader"
{
    Properties
    {
        _BodyColor("Body Color", Color) = (0, 0.2, 0.8, 1)   // Azul fuerte
        _PulseColor("Pulse Color", Color) = (1, 1, 0, 1)     // Amarillo
        _PulseWidth("Pulse Width", Float) = 0.1
        _PulseSpeed("Pulse Speed", Float) = 2.0
        _PulseFrequency("Pulse Frequency", Float) = 2.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BodyColor;
            float4 _PulseColor;
            float _PulseWidth;
            float _PulseSpeed;
            float _PulseFrequency;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 screenUV : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.screenUV = v.uv * 2.0 - 1.0; // Centro en (0,0)
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 centeredUV = i.screenUV;
                float dist = length(centeredUV);
                float timePulse = sin(dist * _PulseFrequency - _Time.y * _PulseSpeed);
                float pulse = smoothstep(1.0 - _PulseWidth, 1.0, abs(timePulse));

                float3 color = lerp(_BodyColor.rgb, _PulseColor.rgb, pulse);
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
