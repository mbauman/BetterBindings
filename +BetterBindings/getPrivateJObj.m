function obj = getPrivateJObj(parent,fieldName)
% getPrivateJObj - gets object from private field of Java object 'PARENT'
import java.lang.reflect.*
field = parent.getClass().getDeclaredField(fieldName);
field.setAccessible(true);
obj = field.get(parent);

end
