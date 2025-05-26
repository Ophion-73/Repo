
Shader "Custom/ExplosiveEnergyCharge"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (0.0, 0.2, 0.8, 1)   // Azul profundo
        _ExplosionColor("Explosion Color", Color) = (1, 0.8, 0.2, 1) // Naranja-amarillo brillante
        _ChargeSpeed("Charge Speed", Float) = 4.0
        _PulseWidth("Pulse Width", Float) = 0.1
        _ExplosionIntensity("Explosion Intensity", Float) = 2.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float4 _ExplosionColor;
            float _ChargeSpeed;
            float _PulseWidth;
            float _ExplosionIntensity;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float dist = length(i.worldPos);
                float pulse = sin(_Time.y * _ChargeSpeed + dist * 10.0);
                float ring = smoothstep(1.0 - _PulseWidth, 1.0, abs(pulse));

                float3 color = lerp(_BaseColor.rgb, _ExplosionColor.rgb, ring * _ExplosionIntensity);
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
