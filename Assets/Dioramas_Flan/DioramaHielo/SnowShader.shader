
Shader "Custom/SnowShader"
{
    Properties
    {
        _SnowColor("Snow Color", Color) = (0.9, 0.95, 1.0, 1)
        _SparkleColor("Sparkle Color", Color) = (1.0, 1.0, 1.0, 1)
        _SparkleScale("Sparkle Scale", Float) = 40.0
        _SparkleSpeed("Sparkle Speed", Float) = 1.5
        _SparkleStrength("Sparkle Strength", Float) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 150

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _SnowColor;
            float4 _SparkleColor;
            float _SparkleScale;
            float _SparkleSpeed;
            float _SparkleStrength;

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

            float hash21(float2 p)
            {
                p = frac(p * float2(123.34, 456.21));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            float sparkleNoise(float2 uv, float t)
            {
                float h = hash21(floor(uv * _SparkleScale + t));
                return step(0.95, h);
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
                float sparkle = sparkleNoise(i.uv, _Time.y * _SparkleSpeed) * _SparkleStrength;
                float3 color = _SnowColor.rgb + sparkle * _SparkleColor.rgb;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
