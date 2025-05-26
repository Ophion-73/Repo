
Shader "Custom/HardIceShader"
{
    Properties
    {
        _IceColor("Base Ice Color", Color) = (0.5, 0.9, 1.0, 1)
        _CrackColor("Crack Highlight", Color) = (0.8, 1.0, 1.0, 1)
        _FresnelPower("Fresnel Power", Float) = 6.0
        _FresnelStrength("Fresnel Strength", Float) = 1.2
        _CrackIntensity("Crack Intensity", Float) = 1.0
        _CrackScale("Crack Scale", Float) = 20.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 300
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _IceColor;
            float4 _CrackColor;
            float _FresnelPower;
            float _FresnelStrength;
            float _CrackIntensity;
            float _CrackScale;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
                float2 uv : TEXCOORD2;
            };

            float hash21(float2 p)
            {
                p = frac(p * float2(123.34, 456.21));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            float crackPattern(float2 uv)
            {
                uv *= _CrackScale;
                float n = hash21(floor(uv));
                float fract = frac(uv.x + uv.y + n);
                return step(0.95, fract);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float fresnel = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), _FresnelPower);
                float3 fresnelEffect = _FresnelStrength * fresnel * _CrackColor.rgb;

                float crack = crackPattern(i.uv) * _CrackIntensity;

                float3 color = _IceColor.rgb + fresnelEffect + crack * _CrackColor.rgb;
                return float4(color, 0.85); // translúcido pero fuerte
            }
            ENDCG
        }
    }
}
