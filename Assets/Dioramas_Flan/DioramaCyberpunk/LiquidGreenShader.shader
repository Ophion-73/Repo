
Shader "Custom/LiquidGreenShader"
{
    Properties
    {
        _LiquidColor("Liquid Color", Color) = (0.2, 1.0, 0.5, 1) // Verde brillante
        _WaveSpeed("Wave Speed", Float) = 2.0
        _WaveScale("Wave Scale", Float) = 10.0
        _DistortionStrength("Distortion Strength", Float) = 0.05
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _LiquidColor;
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

            fixed4 frag(v2f i) : SV_Target
            {
                float time = _Time.y * _WaveSpeed;
                float waveX = sin(i.uv.y * _WaveScale + time);
                float waveY = cos(i.uv.x * _WaveScale + time);
                float2 distortion = float2(waveX, waveY) * _DistortionStrength;

                float2 distortedUV = i.uv + distortion;
                float brightness = 0.7 + 0.3 * sin(time + distortedUV.x * 10);

                float3 finalColor = _LiquidColor.rgb * brightness;
                return float4(finalColor, 0.85); // semi-transparente
            }
            ENDCG
        }
    }
}
