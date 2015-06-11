
struct VS_INPUT
{
	float4 Pos : POSITION;
	float2 Tex : TEXCOORD0;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Color : COLOR0;
	float2 Tex : TEXCOORD0;
};


Texture2D txDiffuse : register(t0);
SamplerState samLinear : register(s0);

cbuffer cbNeverChanges : register(b0)
{
	matrix View;
};

cbuffer cbChangeOnResize : register(b1)
{
	matrix Projection;
};

cbuffer cbChangesEveryFrame : register(b2)
{
	matrix World;
	float4 vMeshColor;
};

//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
PS_INPUT VS(VS_INPUT input, uint vID : SV_VertexID)
{
	PS_INPUT output;
	output.Pos = mul(input.Pos, World);
	output.Pos = mul(output.Pos, View);
	output.Pos = mul(output.Pos, Projection);
	output.Tex = input.Tex;
	output.Color = vID;
	return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS(PS_INPUT input/*, float dep : SV_Depth*/) : SV_Target
{
	float4 tex = txDiffuse.Sample(samLinear, input.Tex);

	float zzz = ( ( (input.Pos.z - 0.3f) / input.Pos.w ) + 0.1f ) * 3.0f;

	// highlighted by Z
	return tex *float4(zzz, zzz, zzz, 1.0f);

	// colored from cbuffer
//	return tex * float4(1.0f, 1.0f, 0.0f, 1.0f) *vMeshColor;
}
