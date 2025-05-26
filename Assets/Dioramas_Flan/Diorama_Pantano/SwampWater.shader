
Shader "Custom/SwampWater"
{
    Properties
    {
        _WaterColor("Water Color", Color) = (0.1, 0.4, 0.2, 0.5)
        _WaveSpeed("Wave Speed", Float) = 0.5
        _DistortStrength("Distort Strength", Float) = 0.01
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _WaterColor;
            float _WaveSpeed;
            float _DistortStrength;

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

            float wave(float2 uv, float t)
            {
                return sin(uv.x * 12.0 + t) + cos(uv.y * 10.0 + t);
            }

            v2f vert(appdata v)
            {
                float t = _Time.y * _WaveSpeed;
                float d = wave(v.uv, t) * _DistortStrength;
                v.vertex.y += d;
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return _WaterColor;
            }
            ENDCG
        }
    }
}
