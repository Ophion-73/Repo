
Shader "Custom/TransparentSeaShader"
{
    Properties
    {
        _WaterColor("Water Color", Color) = (0.0, 0.6, 0.8, 0.5)
        _WaveSpeed("Wave Speed", Float) = 1.0
        _WaveScale("Wave Scale", Float) = 20.0
        _DistortionStrength("Distortion Strength", Float) = 0.03
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _WaterColor;
            float _WaveSpeed;
            float _WaveScale;
            float _DistortionStrength;

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
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float waveDistortion(float2 uv, float time)
            {
                return sin(uv.x * _WaveScale + time) + cos(uv.y * _WaveScale + time * 1.2);
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float time = _Time.y * _WaveSpeed;
                float wave = waveDistortion(i.uv, time) * _DistortionStrength;
                float2 distortedUV = i.uv + wave;

                float alpha = _WaterColor.a * (0.6 + 0.4 * sin(distortedUV.y * 10.0 + time));
                return float4(_WaterColor.rgb, saturate(alpha));
            }
            ENDCG
        }
    }
}
