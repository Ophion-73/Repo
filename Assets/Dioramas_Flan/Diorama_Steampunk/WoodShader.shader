
Shader "Custom/WoodShader"
{
    Properties
    {
        _BaseColor("Base Wood Color", Color) = (0.4, 0.2, 0.1, 1)
        _RingFrequency("Ring Frequency", Float) = 10.0
        _RingNoise("Ring Noise", Float) = 2.0
        _GrainStrength("Grain Strength", Float) = 0.2
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 150

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float _RingFrequency;
            float _RingNoise;
            float _GrainStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float pseudoNoise(float2 p)
            {
                return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 centerUV = i.uv - float2(0.5, 0.5);
                float r = length(centerUV);

                // Simular anillos concéntricos con ruido
                float rings = sin(r * _RingFrequency + pseudoNoise(i.uv) * _RingNoise);
                rings = abs(rings);

                // Simular vetas horizontales
                float grain = sin(i.uv.x * 100.0) * _GrainStrength;

                float brightness = saturate(0.6 + 0.4 * (rings + grain));
                float3 color = _BaseColor.rgb * brightness;

                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
