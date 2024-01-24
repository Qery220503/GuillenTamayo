export const getAnamnesisService = async (documento) => {
  try {
    const { data } = await axios.get(`/api/anamnesis/paciente/${documento}`);
    // console.log(JSON.parse(JSON.stringify(data)));
    return data;
  } catch (error) {
    throw error;
  }
};

export const getRecetasService = async (id) => {
  try {
    const { data } = await axios.get(
      `/api/ordenes-laboratorio/ver-recetas/${id}`
    );
    // console.log(data);
    return data;
  } catch (error) {
    throw error;
  }
};
