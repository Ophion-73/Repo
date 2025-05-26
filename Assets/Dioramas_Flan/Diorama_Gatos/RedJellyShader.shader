
Shader "Custom/RedJellyShader"
{
    Properties
    {
        _JellyColor("Jelly Color", Color) = (1.0, 0.2, 0.2, 0.6)
        _ShineColor("Shine Color", Color) = (1, 1, 1, 1)
        _ShineStrength("Shine Strength", Float) = 1.5
        _JellyWobble("Jelly Wobble", Float) = 0.02
        _WobbleSpeed("Wobble Speed", Float) = 2.0
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 250

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _JellyColor;
            float4 _ShineColor;
            float _ShineStrength;
            float _JellyWobble;
            float _WobbleSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                float t = _Time.y * _WobbleSpeed;
                v.vertex.y += sin(v.uv.x * 10.0 + t) * _JellyWobble;
                v.vertex.x += cos(v.uv.y * 10.0 + t) * _JellyWobble;

                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float shine = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), 4.0);
                float3 finalColor = _JellyColor.rgb + _ShineColor.rgb * shine * _ShineStrength;
                return float4(finalColor, _JellyColor.a);
            }
            ENDCG
        }
    }
}
