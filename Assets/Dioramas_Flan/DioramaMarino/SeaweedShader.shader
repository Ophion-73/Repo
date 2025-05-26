
Shader "Custom/SeaweedShader"
{
    Properties
    {
        _SeaweedColor("Seaweed Color", Color) = (0.1, 0.5, 0.2, 1)
        _WaveSpeed("Wave Speed", Float) = 1.0
        _WaveStrength("Wave Strength", Float) = 0.05
        _WaveFrequency("Wave Frequency", Float) = 8.0
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

            float4 _SeaweedColor;
            float _WaveSpeed;
            float _WaveStrength;
            float _WaveFrequency;

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

            v2f vert(appdata v)
            {
                float time = _Time.y * _WaveSpeed;
                float wave = sin(v.uv.y * _WaveFrequency + time) * _WaveStrength;
                v.vertex.x += wave;

                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return _SeaweedColor;
            }
            ENDCG
        }
    }
}
