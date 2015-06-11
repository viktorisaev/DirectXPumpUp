
struct VS_INPUT
{
	float3 Pos : POSITION;
	float2 Tex : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos : SV_POSITION;
	float Color : COLOR0;
	float2 Tex : TEXCOORD0;
};


Texture2D txDiffuse : register(t0);
SamplerState samLinear : register(s0);



//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
VS_OUTPUT VS(VS_INPUT input, uint vID : SV_VertexID)
{
	VS_OUTPUT output;
	output.Pos = float4(input.Pos.xyz, 1.0f);
	output.Tex = input.Tex;
	output.Color = vID;
	return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS(VS_OUTPUT input) : SV_Target
{
	float4 tex = txDiffuse.Sample(samLinear, input.Tex);
    return tex * float4( 0.5f * input.Color.r, 1.0f, 0.0f, 1.0f );    // Yellow, with Alpha = 1
}